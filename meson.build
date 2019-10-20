project('eva', 'c', version: '0.1', default_options: ['c_std=c99'])

sdl_dep = dependency('sdl2', fallback: ['sdl2', 'sdl2_dep'], required: get_option('SDL'))

subdir('src')
subdir('test')
