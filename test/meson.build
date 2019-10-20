if not get_option('WITH_TESTS')
	subdir_done()
endif

test_src = files('test.c')

test_name = meson.project_name() + '-test'
test_exe = executable(test_name, test_src, link_with: eva_lib)
test(test_name, test_exe)
