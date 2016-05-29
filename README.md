# mdSlide has been re-named to [Marp](https://github.com/yhatt/marp/) !

[![](https://raw.githubusercontent.com/yhatt/marp/master/images/marp.png)](https://github.com/yhatt/marp/)

> NOTICE: THIS REPOSITORY IS NO LONGER USED.

---

mdSlide
===

**Markdown slide writer, powered by [Electron](http://electron.atom.io/).**

![mdSlide](screenshot.png)

## Usage

### Install

Please refer releases page of [Marp](https://github.com/yhatt/marp/releases). *Do you want [mdSlide's older releases?](https://github.com/yhatt/mdslide/releases)*

### How to write slides?

Split slides by horizontal ruler `---`. It's very simple. Please refer to [example.md](https://raw.githubusercontent.com/yhatt/mdslide/master/example.md).

```md
# Slide 1

foobar

---

# Slide 2

foobar
```

## For developers

### Getting started

```
npm install
```

And run below gulp task to execute:

```
gulp run
```

### Create release builds

```
gulp release
```

Please set application version in `package.json`.

#### OS specific

##### Windows

If you want to build for Windows in other platforms, please install [Wine](https://www.winehq.org/) to rewrite Electron's resources.

##### OSX

To build for Darwin is only supported in OSX. Please install [appdmg](https://github.com/LinusU/node-appdmg) to create archive (`.dmg`) for Darwin release.

```
npm install appdmg
```

###### Notices

- **Don't add development dependency of `appdmg` to `package.json`.** The release task would fail in other platforms.
- *`gulp-appdmg` is no longer in use since v0.0.4.*

## Licenses

Copyright &copy; 2016 [Yuki Hattori](https://github.com/yhatt).
This software released under the [MIT License](https://opensource.org/licenses/mit-license.php).
