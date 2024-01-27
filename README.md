# what's this?
ELS for FiveM with [WM-ServerSirens](https://github.com/Walsheyy/WMServerSirens)

By default there is a server side siren

## Note:
- This script does not support making horn changes by default
  - If you want to customize the horn as well, please refer to the wiki

### Requirements
- [WM-ServerSiren](https://github.com/Walsheyy/WMServerSirens)
- ELS Car and `car_name.xml`


#### Default Controls
https://github.com/MrDaGree/ELS-FiveM/wiki/Controls

#### Installation Guide
1. Clone the repository or download the [latest version](../../releases/latest).
    * Note: if cloning, pass `[ELS]` or similar to `path` argument (e.g. `git clone https://github.com/tah5882/ELS-FiveM [ELS]`, make sure you are in `resources`, also).
2. Place inside your server's `resources` directory.
3. Create a file called 'vcf.lua' and copy the file contents of 'vcf._default_.lua' into that file, but do not delete the default file.
4. Make altercations accordingly.
5. Place any VCF files inside the `vcf` directory so they are able to be found.
6. Enjoy!

### Do you need Japanese version?
[Click me!](https://github.com/tah5882/ELS-FiveM/wiki/Japanese-README)

#### Convars
| Convar              | Parameters        | Function                                                                                                              | Example Usage                | Default State |
|---------------------|-------------------|-----------------------------------------------------------------------------------------------------------------------|------------------------------|---------------|
| `els_outputLoading` | boolean           | This outputs the loaded vehicles that have been specified in the vcf.lua                                              | `setr els_outputLoading true` | "false"      |
| `els_debug`         | boolean           | This prints information to both client or server with information of what is happening                                | `setr els_debug true`         | "false"      |
| `els_developer`     | boolean           | Provides access to developer features which may break ELS for clients on your server, should only be used when asked. | `setr els_developer true`     | "false"      |
| `els_warnOnJoin`    | boolean           | Displays a warning if the current version is outdated                                                                 | `setr els_warnOnJoin true`    | "false"      |
