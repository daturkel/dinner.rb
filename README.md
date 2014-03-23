# Dinner.rb

- [What's Dinner?](#what)
- [Installation](#install)
- [Usage](#usage)
- [Example](#example)
- [Uninstallation](#uninstall)
- [Contributing](#contribute)

## <a name="what">What's Dinner?</a>

Dinner is a Ruby gem designed to replicate some of the feature set of [Hammer](http://hammerformac.com/) for Mac. I'm a huge fan of Hammer's ability to do HTML includes and variables, so I made Dinner to see how well I could do it myself without the app, 'cause why not?

Basically, you can write HTML pages with lines like `<!-- @include _header.html -->` and then Dinner will automagically copy your header file into all of your HTML pages, allowing you to edit that header file and see your changes propagate across all your files after running Dinner! This is perfect for building static sites where you don't want to bother with PHP includes but still want to be able to easily edit your templates (or 'plates, hence Dinner, get it?).

The project is similar in scope to [grunt-includes](https://github.com/vanetix/grunt-includes) but does not involve setting up [grunt](http://gruntjs.com/) tasks, uses a different syntax, and is Ruby-based rather than JS based.

### What it does so far:

- Include `_foo.html` files into `bar.html` files and move the compiled results into a build directory, but only when you manually run the app
- Makes a `dinconfig.yaml` file where you can:
    - Edit the build folder name
    - More to come
- Finds placeholder tags and switches them for [placehold.it](http://placehold.it) `img` tags. (See [Example](#example) below)
- That's basically it

### What I'm going to do for sure
- Better documentation
- Support Hammer-style [HTML variables](http://hammerformac.com/docs/tags/variables)
- Fix behavior with HTML files that are inside directories in the working directory (currently the directory structure will be flattened inside the build folder)
- Copying CSS and JS files (perhaps more) to the build folder so that loading the build file in a web browser will not result in dead links to stylesheets and scripts which are in the parent directory
- <del>Make a easy-to-use YAML config file where you can change:</del> done!
    - <del>Edit the build folder name</del> done!
    - what non-HTML files should be copied to the build directory (and if you want them minified)
    - probably more stuff
- Use the [listen](https://github.com/guard/listen) gem to automatically recompile files when they're edited, so the app doesn't need to be manually run
- Add rspec tests
- Put it on RubyGems when it's moderately ready
- <del>Replicate Hammer's [image placeholders](http://hammerformac.com/docs/tags/placeholder) feature</del> done!

### What maybe I'll do
- Support includes within includes
- Support includes that are not in `_foo.html` name format
- Replicate Hammer's [navigation helpers](http://hammerformac.com/docs/tags/navigation.html) feature
- Add Sass/SCSS compilation

### What I definitely won't do but feel free to contribute
- Coffeescript compilation
- Replicate Hammer's [cache](http://hammerformac.com/docs/cache) feature


## <a name="install">Installation</a>

Dinner isn't on RubyGems yet and is still in early dev stages. If you want to play with it or contribute, go ahead and run

    git clone https://github.com/daturkel/dinner.rb.git

Then `cd` to the cloned directory and run

    gem build dinner.gemspec

followed by

    gem install *.gem

## <a name="usage">Usage</a>

**Warning**: This product is in early alpha and if used improperly, or if I messed something up, could easily trash your files. I recommend you make a backup of your entire working directory or use version control before running `dinner` in your directory (at least at this early stage of development). By using `dinner`, you do so at your own risk.

Right now, since Dinner's functionality is fairly limited, this section is quite simple! After installing the gem, simply `cd` to your working directory. If you have not already, you should isolate all your project files into their own directory to avoid accidental compilation of other unrelated files. 

Write HTML pages into files with typical names (`about.html`) and files that will be included into files that have leading-underscore names (`_header.html`). In your page files (like `about.html`), where you want an include, insert a single line with a comment in this form: `<!-- @include _foo.html -->` (or, alternatively, as `<!-- @include _foo -->`, without the `.html`, Dinner will assume you meant it) where `_foo.html` is the name of your include file. When you run `dinner` in the working directory, Dinner will automatically find the include file and replace the comment with it, verbatim (no changes to indent amount or anything) and output the new page into your `build/` directory. If Dinner is unable to find an include file, it will simply leave the comment in place and alert you with an error message in the terminal.

## <a name="example">Example</a>
In `about.html`:

```html
<!DOCTYPE HTML>
<html lang="en">
<head>
	<title>About me!</title>
</head>

<body>
    <!-- @include _head.html -->
    <h2>Welcome</h2>
    <!-- @placeholder 300x400 --><!-- @placeholder 400x500 -->
    <p>This site is all about me! Isn't it neato?</p>
</body>
</html>
```

In `_head.html`:
```html
    <p>This banner goes across every page of my website and now I can change it on all of them easily!</p>
    <p>That's sick!</p>
```

And, after Dinner has been run, in `build/about.html`:
````html
<!DOCTYPE HTML>
<html lang="en">
<head>
	<title>About me!</title>
</head>

<body>
    <p>This banner goes across every page of my website and now I can change it on all of them easily!</p>
    <p>That's sick!</p>
    <h2>Welcome</h2>
    <img src="http://placehold.it/300x400"><img src="http://placehold.it/400x500">
    <p>This site is all about me! Isn't it neato?</p>
</body>
</html>
````

It's that easy!

## <a name="uninstall">Uninstallation</a>

To uninstall dinner, simply run `gem uninstall dinner` and when prompted to remove the executable, answer `y`.


## <a name="contribute">Contributing</a>

Feel free to contribute by filing an issue or submitting a pull request:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
