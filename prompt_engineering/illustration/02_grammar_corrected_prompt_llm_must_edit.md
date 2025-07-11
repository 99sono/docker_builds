The verification scripts you created have an important problem:
They are written as if they should run inside the Docker container, 
when they should instead execute via `docker exec` commands similar to the 
`development_image/01_build_base_software_image/verify/08_verify_sshd_config.sh` script.

Additionally, we need a startup script like 
`development_image/01_build_base_software_image/verify/01_A_run_built_container_entrypoint_script.sh`
for the Level 02 container built by
`development_image/02_build_dev_environments_image/build.sh`.
