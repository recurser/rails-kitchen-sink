
About
-----

I needed a solid base to build my own rails projects from. Since integrating all these disparate pieces isn't the easiest thing in the world, I decided to release this sample site in the hope that it would save you some time as well.

The demo application is designed to provide a solid, generic skeleton to base your next rails project on, and includes everything you'll need to dive straight in and get started.

Demo Site
---------

You can try out a live demo of the project at [railskitchensink.com](http://railskitchensink.com/). The database will be automatically re-generated every hour, so don't be surprised if any changes disappear.

License
-------

This project is distributed under the [MIT License](http://en.wikipedia.org/wiki/MIT_license). See the [License](https://github.com/recurser/rails-kitchen-sink/blob/master/LICENSE) file for details.

Installation
------------

To get started, first download the source via git

```bash
> git clone git://recursive-design.com/rails-kitchen-sink.git
> cd rails-kitchen-sink
```

Next, install the requisite gems:

```bash
> gem install bundler
> bundle install
```

Set up the database:

```bash
> rake db:setup
```

Finally, run the local development server to try it out:

```bash
> rails s
```

The demo application should now be available at [http://localhost:3000/](http://localhost:3000/).

What's Included?
----------------

I've tried to create a sensible base to start build your Rails 3 applications off of, with all the packages I generally use pre-integrated. _Rails Kitchen Sink_ currently combines:

* [Devise](http://github.com/plataformatec/devise) authentication.
* [CanCan](http://github.com/ryanb/cancan) authorization.
* [HAML](http://haml-lang.com/) templates.
* [CoffeeScript](http://jashkenas.github.com/coffee-script/) support.
* [metric_fu](http://metric-fu.rubyforge.org/) reports.
* Full [RSpec](http://rspec.info/) test suite.
* [Spork](http://github.com/timcharper/spork) DRb server.
* [960](http://960.gs/) CSS grid system.
* [Jammit](http://documentcloud.github.com/jammit/) asset packaging.
* [Formtastic](http://github.com/justinfrench/formtastic) forms.


Testing
-------

_Rails Kitchen Sink_ comes pre-configured for [Spork](http://github.com/timcharper/spork) and [autotest](http://www.zenspider.com/ZSS/Products/ZenTest/#rsn) support. I generally work by running _spork_ in one terminal:

```bash
> cd rails-kitchen-sink
> spork
Using RSpec
Loading Spork.prefork block...
Spork is ready and listening on 8989!
```

... and running _autotest_ in another:

```bash
> cd rails-kitchen-sink
> autotest
........................................................................................

Finished in 29.27 seconds
88 examples, 0 failures
```

Autotest will run the test suite automatically whenever you save changes, and if you're working on OSX, it will provide [Growl](http://growl.info/) feedback every time the test suite is run:

![Autotest growl notification](http://recursive-design.com/images/projects/rails-kitchen-sink/autotest_growl_notification.png)

Deploying To Heroku
-------------------

To deploy the application to [Heroku](http://heroku.com/,) simply run _heroku create_:

```bash
> heroku create
Creating evening-beach-14... done
Created http://evening-beach-14.heroku.com/ | git@heroku.com:evening-beach-14.git
Git remote heroku added
```

The _evening-beach-14_ part will vary depending on the name Heroku chooses for your application.

To push your newly created application to Heroku, do a _git push heroku master_:

```bash
> git push heroku master
Counting objects: 1669, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (629/629), done.
Writing objects: 100% (1669/1669), 382.36 KiB, done.
Total 1669 (delta 955), reused 1657 (delta 949)

-----> Heroku receiving push
-----> Rails app detected
-----> Gemfile detected, running Bundler version 1.0.0
       Unresolved dependencies detected; Installing...
       Fetching source index for http://rubygems.org/
       
       ...
       [installing a bunch of gems]
       ...
       
       Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.
       
       Your bundle was installed to `.bundle/gems`
       Compiled slug size is 25.6MB
-----> Launching.... done
       http://evening-beach-14.heroku.com deployed to Heroku

To git@heroku.com:evening-beach-14.git
 * [new branch]      master -> master
```

Next, create the database on Heroku:

```bash
> heroku rake db:setup
```

You should also install the free [SendGrid](http://sendgrid.com/) add-on for email delivery:

```bash
> heroku addons:add sendgrid:free
```

Your application should now be available at [http://evening-beach-14.heroku.com/](http://evening-beach-14.heroku.com/) (substitute the domain you received from _git push heroku_ here).

Whenever you push changes to git, you can update heroku by doing _git push heroku_ again.

Git hooks
---------

CoffeeScript and Compass both require generated files to be saved when they're compiled - this causes a problem on Heroku because access to the filesystem is limited. There are various hacks to get around this by saving to the _tmp_ folder and re-routing requests, but I decided it was probably easiest to just add the generated files to git and deploy them normally.

To achieve this, I added a post-commit hook to the repository to generate these files whenever changes are committed. To add these, create the file _.git/hooks/pre-commit_ , make it executable, and add the following contents:

```bash
#!/bin/sh

compass compile
rake public/javascripts/application.js
jammit
git add public/assets/common*
git add public/javascripts/application.js
```

The first two commands generate the CSS and Javascript respectively, the 3rd command packages them up using Jammit, and the last two make sure they are included in the commit.

Internationalization
--------------------

_Rails Kitchen Sink_ is fully I18N-ready, but unfortunately the only translation is currently (i assume fairly badly) auto-generated-french from Google translate. If you'd like to contribute a translation, you can start by looking at the [translation files](https://github.com/recurser/rails-kitchen-sink/tree/master/config/locales) and [static pages](https://github.com/recurser/rails-kitchen-sink/tree/master/app/views/pages). There's not a great deal of text to translate, so if anyone is feeling particularly generous and/or bored, additional translations would be very much appreciated! 

Stylesheets
-----------

Stylesheets in the _public/stylesheets_ folder are automatically generated by compass, so any changes you make to these files will be lost. Instead, you should edit the _sass_ files in _app/stylesheets_.

When altering stylesheets during development, you should run _compass watch_ to make sure your changes are automatically compiled to _public/stylesheets_:

```bash
> compass watch
>>> Compass is watching for changes. Press Ctrl-C to Stop.
```

Javascript
----------

Similarly, _public/javascripts/application.js_ is automatically generated by the CoffeeScript compiler. Instead of editing it directly, edit _application/scripts/application.coffee_ instead. 

Unlike Compass, there is no need to run a _watch_ script for this file during development - it will automatically be compiled for you.

Asset Packaging
---------------

JavaScript and CSS are automatically compressed and packaged for production with [Jammit](http://documentcloud.github.com/jammit/). During development, the non-compressed versions will be served to speed things up. This packaging should be fairly transparent to you if you set up the git pre-commit hook described above - if you choose not to do this you will need to run the _jammit_ command manually before committing changes.

Bug Reports
-----------

If you come across any problems, please [create a ticket](https://github.com/recurser/rails-kitchen-sink/issues) and we'll try to get it fixed as soon as possible.


Contributing
------------

Once you've made your commits:

1. [Fork](http://help.github.com/fork-a-repo/) rails-kitchen-sink
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create a [Pull Request](http://help.github.com/pull-requests/) from your branch
5. That's it!


Author
------

Dave Perrett :: mail@recursive-design.com :: [@recurser](http://twitter.com/recurser)


Copyright
---------

Copyright) (c) 2010 Dave Perrett. See [License](https://github.com/recurser/rails-kitchen-sink/blob/master/LICENSE) for details.

