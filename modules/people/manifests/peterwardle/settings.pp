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
    include osx::dock::dim_hidden_apps
    #include osx::dock::clear_dock
    include osx::dock::autohide
    include osx::dock::hide_indicator_lights
    class { 'osx::dock::icon_size': size => 30 }
    class { 'osx::dock::position': position => 'bottom' }
    class { 'osx::dock::magnification': magnification => true, magnification_size => 64 }
}