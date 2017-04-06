// # Task automation for Ghost
//
// Run various tasks when developing for and working with Ghost Desktop.
//
// **Usage instructions:** can be found in the by running `grunt --help`.
//
// **Debug tip:** If you have any problems with any Grunt tasks, try running them with the `--verbose` command

const configureGrunt = function (grunt) {
    // #### Load all grunt tasks
    //
    // Find all of the task which start with `grunt-` and load them, rather than explicitly declaring them all
    require('matchdep').filterDev(['grunt-*', '!grunt-cli']).forEach(grunt.loadNpmTasks);

    // Optional, platform specific grunt plugins.
    if (process.platform === 'linux') {
        grunt.loadNpmTasks('grunt-electron-installer-debian');
    }

    const config = {
        'electron-installer-debian': {
            app: {
                options: {
                    name: 'Ghost',
                    maintainer: 'Felix Rieseberg <felix@felixrieseberg.com>',
                    homepage: 'https://tryghost.com',
                    genericName: 'Blogging Software',
                    arch: 'amd64',
                    icon: `${__dirname}/assets/icons/ghost-macos.png`,
                    bin: 'Ghost',
                    productDescription: 'A beautiful desktop application enabling you to easily manage multiple Ghost blogs and work without distractions.'
                },
                src: './electron-builds/Ghost-linux-x64',
                dest: './electron-builds/Ghost-linux-x64-installer'
            }
        },

        trimtrailingspaces: {
            main: {
                src: ['app/**/*.js', 'tests/**/*.js', 'scripts/**/*.js', 'Gruntfile.js', 'main/**/*.js'],
                options: {
                    filter: 'isFile',
                    encoding: 'utf8',
                    failIfTrimmed: false
                }
            }
        }
    };

    grunt.initConfig(config);
};

module.exports = configureGrunt;
