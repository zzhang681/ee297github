set_global_assignment -entity "macacc" -library "lib_macacc" -name IP_TOOL_NAME "altera_fp_acc_custom"
set_global_assignment -entity "macacc" -library "lib_macacc" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "macacc" -library "lib_macacc" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_macacc" -name SPD_FILE [file join $::quartus(sip_path) "macacc.spd"]

set_global_assignment -library "lib_macacc" -name MISC_FILE [file join $::quartus(sip_path) "macacc_sim/dspba_library_package.vhd"]
set_global_assignment -library "lib_macacc" -name MISC_FILE [file join $::quartus(sip_path) "macacc_sim/dspba_library.vhd"]
set_global_assignment -library "lib_macacc" -name MISC_FILE [file join $::quartus(sip_path) "macacc_sim/macacc.vhd"]
