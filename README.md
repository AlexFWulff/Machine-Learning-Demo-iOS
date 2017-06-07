### Swift Tutorial: Native Machine Learning and Machine Vision in iOS 11

It has arrived. With iOS 11, Apple finally introduced a native machine learning
and machine vision framework. This opens up a whole host of new possibilities,
promising great leaps forward in apps and games of all natures.

![](https://cdn-images-1.medium.com/max/1600/1*OZNZMNqqJYqH-LpNFYKI3w.png)

Machine learning solutions have been available for a while in the cloud, but
these systems require a constant internet connection and oftentimes have a very
noticiable delay on iOS for obvious reasons. This also creates a security risk
for sensitive data. Some third-party  Swift AI systems have begun to take hold
inside of a select few apps, but such frameworks never hit the mainstream
development community. With Apple’s new introduction at the 2017 WWDC it is
likely that many of your favorite apps will see signifigant
machine-learning-related updates.

Interested in seeing how you can integrate Apple’s new APIs into your very own
apps? It’s easier than you think!

![](https://cdn-images-1.medium.com/max/1600/1*fI3VsBMqXglx0S0tU6R1tg.png)

The first thing you’re going to need to do is download the Xcode 9 beta:
[https://developer.apple.com/download/](https://developer.apple.com/download/).
Be warned: this is a very large file and will take some time to download. In
addition, this early beta version is super buggy and still has a lot of problems
(some of which I will discuss later). While Xcode is downloading you can read
through the rest of this post so you’re ready to go when it’s finished.

Now head over to the GitHub repo I created for this article and download the
Xcode project:

![](https://cdn-images-1.medium.com/max/1600/1*6yOsSeQyDlPbgxuF6X0HJQ.png)
<span class="figcaption_hack">Sample results for the image on the right</span>

My sample project will take in an image and spit out likely categorizations with
their respective level of confidence. All the calculations are handled on-device
utilizing Apple’s new Core ML and Vision frameworks.

The project itself is surprisingly sparse. I want to draw your attention to one
file in particular: GoogLeNetPlaces.mlmodel. This file is a trained machine
vision model that was created by Google researchers a few years ago. Apple’s new
machine learning APIs allow developers to easily access these standardized
models inside their iOS apps. When you drag a .mlmodel file into your app Xcode
will automatically create a Swift wrapper for it. Some of the model files can be
upwards of hundreds of megabytes in size.

Unfortunately, Core ML files are not even remotely human-readable like a .plist
or .storyboard. Instead, they are just a large collection of bytes that tell the
device how to arrange the “neurons” that handle inputs. The more complex a
model, the larger its size.

![](https://cdn-images-1.medium.com/max/1600/1*6agZ1CcGVwiOaX3gNP8cYw.png)

Apple has collected four different trained models for your use. You can find
these at
[https://developer.apple.com/machine-learning/](https://developer.apple.com/machine-learning/).
Apple’s Core ML Tools Python package allows developers to convert preexisting
models into the iOS-accessible Core ML format. As the format gains more traction
I expect that you will be able to get your hands on trained models for all sorts
of use cases.

![](https://cdn-images-1.medium.com/max/1600/1*CgqOISkGGnUbtoWeqKzE9A.png)
<span class="figcaption_hack">One of the many bugs: even though the project compiles, the editor still thinks
that the Swift wrapper doesn’t exist.</span>

Next open up the ViewController file. The first snippet of code (pictured above)
simply tries to create a variable to store the Vision representation of your
chosen model. Even if it appears that there’s an error in this section the
project should still compile. This is one of the many bugs I’ve found during the
brief time that I’ve used Xcode 9 beta.

With support for Core ML models Apple also introduced its own machine vision
API: the aptly-named Vision. Vision contains many different machine vision
models that can detect faces, barcodes, text, and more. Vision also provides
wrappers for image-based Core ML models. Some of these wrappers are specific to
certain types of models. For example, the model used in this project accepts an
image as the input and returns a descriptive string as the output. As this is a
very common thing to do, Apple has included a Vision wrapper for it. For
non-image-based models Apple has created [a small sample
project](https://developer.apple.com/documentation/coreml/integrating_a_core_ml_model_into_your_app)
demonstrating their use. This is completely independent of Vision and solely
relies on Core ML.

![](https://cdn-images-1.medium.com/max/1600/1*SnJyjxV-gzCa9owrfgA8Ew.png)

The next snippet sets up and handles the request. In the project navigator you
should see a variety of different images to try out on this model. Replace the
“airport” string with any of the other image names, build and run the project,
and see how the results outputted to the console change.

Strangely enough, lower-resolution images seem to have the highest confidences
for their most-likely categorization. I’m just an 18-year-old kid so I can’t
really explain to you why this happens. If someone reading my article knows why
this is the case please leave a response below. I’d love to find out!

![](https://cdn-images-1.medium.com/max/1600/1*biN1QzDI5N9WFxqSHull8w.png)

The last code snippet simply takes the results of the request and prints them. I
haven’t implemented any “graceful failing” in this demo, so if something goes
wrong the whole app will crash.

Another large bug I noticed that affects this project deals with dragging and
dropping files into the project navigator. Don’t even attempt this in Xcode 9
(until the problem is fixed) as it will create huge problems with dependency
chains. Just open up the Xcode project in an earlier version of Xcode, select
copy items if needed, and confirm.

![](https://cdn-images-1.medium.com/max/1600/1*FnFPKss7G8lL-5Tv6vz_Bw.png)

The last bug that may affect you will sometimes crop up when running your
project. If the simulator fails to launch just quit out of both the simulator
and Xcode. They should both work for a while until you need to do this again.
Enjoy the new look and feel of the simulator as well as a little preview of iOS
11!

Hopefully my sample project gives you a brief overview of just how easy Apple
made machine learning in iOS 11. Just drag in a model, do something with the
results, and be on your way! The other three models that Apple linked should be
compatible with the same VNCoreMLRequest, as they all take in images and output
classification information.

*****

Let me know what you thought of this tutorial. To see more of my work check out
my website, [www.AlexWulff.com,](http://www.AlexWulff.com,) and my [Medium
page](https://medium.com/@Alex_Wulff).
