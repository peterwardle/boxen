class people::peterwardle::settings {

    # Finder
    include osx::finder::unhide_library
    include osx::finder::enable_quicklook_text_selection
    include osx::finder::show_all_filename_extensions
    include osx::finder::no_file_extension_warnings

    # Safari
    include osx::safari::enable_developer_mode

    # Miscellaneous
    include osx::no_network_dsstores
    class { 'osx::mouse::button_mode': mode => 2 }

    # Dock
    class { 'osx::dock::icon_size': size => 30 }
    class { 'osx::dock::position': position => 'right' }
    class { 'osx::dock::magnification': magnification => true, magnification_size => 64 }
}