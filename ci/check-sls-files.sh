#!/usr/bin/bash
set -euo pipefail

# Checks the SLS files in the qubes-mgmt-salt-user/ directory for conformity
# with the defined style guide in docs/style-guide.md

main()
{
  local exit_code

  check_qube_names
  check_for_required_states
  check_file_includes
  # TODO: Prefer double-quotes
  check_for_vimline_comment

  exit "${exit_code:-0}"
}

# Check qube names
check_qube_names()
{
  local is_valid
  local prefix
  local qvm_class_dirs
  local qvm_name
  local valid_prefixes

  qvm_class_dirs=$(echo qubes-mgmt-salt-user/{appvms,dispvms,templates}/)

  for class_dir in ${qvm_class_dirs}
  do
    case $(basename "${class_dir}") in
      "appvms")
        valid_prefixes=("app-" "id-" "sys-" "vault-")
        ;;
      "dispvms")
        valid_prefixes=("disp-" "dvm-")
        ;;
      "templates")
        valid_prefixes=("on-" "provides-" "uses-app-" "uses-stack-")
        ;;
      *)
        ;;
    esac

    for qvm_sls in $(echo "${class_dir%%/}"/*/)
    do
      qvm_name="$(basename "${qvm_sls}")"
      is_valid=false
      for prefix in "${valid_prefixes[@]}"
      do
        [[ ${qvm_name} = ${prefix}* ]] \
          && is_valid=true
      done

      if [[ ${is_valid} != true ]]
      then
        echo "Invalid qube name ${qvm_name} in ${class_dir%%/}/${qvm_name}"
        exit_code=1
      fi
    done
  done
}

# Check that the required SLS files are in the VM state directories
check_for_required_states()
{
  local required_sls_files="init.sls create_vm.sls configure.sls"
  local sls_dirs

  sls_dirs=$(echo qubes-mgmt-salt-user/{appvms,dispvms,templates}/*/)

  for dir in ${sls_dirs}
  do
    for required_sls in ${required_sls_files}
    do
      if [[ ! -f "${dir%%/}/${required_sls}" ]]
      then
          echo "${dir} is missing ${required_sls}"
          exit_code=1
      fi
    done
  done
}

check_file_includes()
{
  local dir
  local relative_filepath
  local sls_dirs

  sls_dirs=$(echo qubes-mgmt-salt-user/{appvms,dispvms,templates}/*/)

  for dir in ${sls_dirs}
  do
    if [[ -d ${dir%%/}/files ]]
    then
      files=$(find "${dir%%/}"/files -type f)

      for file in ${files}
      do
        relative_filepath="${file/${dir}files\//}"
        if [[ "${relative_filepath}" != dom0* ]] && [[ "${relative_filepath}" != vm* ]]
        then
          echo "Invalid base directory for file include: ${relative_filepath}"
          exit_code=1
        fi
      done
    fi
  done
}

# Check for correct vimline
check_for_vimline_comment()
{
  local state_files
  local vimline

  state_files=$(echo qubes-mgmt-salt-user/**/*.sls qubes-mgmt-salt-user/*.top)
  vimline="{#- vim: set ft=salt syn=salt.jinja.yaml ts=2 sw=2 sts=2 et : -#}"

  for file in ${state_files}
  do
    last_line=$(tail -n1 "${file}")
    if test ! "${last_line}"  == "${vimline}"
    then
      echo "${file} has a missing or incorrect vimline"
      exit_code=1
    fi
  done
}

main
