dune_exe = find_program('dune', required: get_option('ASM'))

if not dune_exe.found()
	subdir_done()
endif

asm_dune_target = 'main.exe'
asm_exe = custom_target('asm',
	command:[
		files('build.sh'),
		dune_exe,
		asm_dune_target,
		meson.current_source_dir() / 'src',
		meson.current_build_dir(),
		'@OUTPUT@'
	],
	input: files(
		'src/main.ml',
		'src/Instructions.ml',
		'src/parser/lexer.mll',
		'src/parser/parser.mly'
	),
	output: 'assembler',
	install: true,
	install_dir: get_option('bindir')
)
