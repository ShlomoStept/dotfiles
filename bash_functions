# bash shell functions

# look -> cds into directory and then prints out the folders
look() { cd "$@"; ls; }

#--------------------------------------
# ---> 
# --------------------------------------
# look() { cd "$@"; ls; }

# --------------------------------------
# rmall - removes all the files recursivly and answers yes for all the overrides
rmall() { yes "yes" | rm -vRI "$@"; } 
# --------------------------------------


#--------------------------------------
#  repeat - takes as args (1) in the number of times you want to run the script as the first argument 
#              and (2) runs the string after as a shell command
# repeat() {
#   local times=$1
#   shift
#   local command="$@"
#   for i in $(seq 1 $times)
#   do
#     echo "Run $i - $ ${command}"
#     echo "---------------------------------"
#     eval "$command"
#     echo
#   done
# }
repeat() {
  local times=$1
  shift
  local command="$@"
  for i in $(seq 1 $times)
  do
    eval "$command"
    echo
  done
}

# --------------------------------------



#--------------------------------------
#  zipclean -  zips a folder on a Mac without including the __MACOSX folder, 
#         using archive_name and folder_to_be_zipped as arguments
zipclean() {
    archive_name=$1
    folder_to_be_zipped=$2
    zip -r -X "${archive_name}.zip" "${folder_to_be_zipped}"
}


#--------------------------------------
# condapip - Install packadges to the pip attached to the conda env in use, 
# and not the base pip for the computer 
condapip() { 
  # Get the current conda environment name 
  local env_name=$CONDA_DEFAULT_ENV

  # Check if in a conda environment 
  if [[ -z $env_name ]]; then 
    echo "Not in a conda environment"
  else
    # Install packages using pip in the current conda environment --> removed the install add it if needed    $CONDA_PREFIX/bin/pip install "$@"
    $CONDA_PREFIX/bin/pip "$@" 
  fi
}


#--------------------------------------# 
# create_conda_reqs - bash function that creates both a pip and conda requirements file
#   for the current conda environment:
#--------------------------------------# 

create_conda_reqs() { 
    # Get the current conda environment name 
    local env_name=$CONDA_DEFAULT_ENV
  
    # Check if in a conda environment 
    if [[ -z $env_name ]]; then 
      echo "Not in a conda environment" 
    else 
      # Create pip requirements file 
      $CONDA_PREFIX/bin/pip freeze > requirements.txt
    
      # Create conda requirements file 
      conda list --export > conda-requirements.txt 
    fi
}
