eva_src = files('disassemble.c')

eva_lib = static_library(meson.project_name(), eva_src)

eva_exe = executable(meson.project_name(),
	files('vm.c'),
	# dependencies: sdl_dep,
	link_with: eva_lib,
	install:true)
