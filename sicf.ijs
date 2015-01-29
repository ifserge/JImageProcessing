load 'graphics/jpeg'
load 'viewmat'

NB. Utilities for presenting grayscale image on viewmat
RGB=:( #:i.8){0 255
ALL=:>"0:;:'BLACK BLUE GREEN AQUA RED MAGENTA YELLOW WHITE'
ro=: 13 :'<.0.5+y'
we=: 13 :'+/"1[0.3 0.59 0.11*"1 y'
gray=: 13 :'3#"0 ro we y'

NB. Read jpeg image
filename =: jpath '~user/projects/SICF/64.jpg'
$ w =: readjpeg filename
NB. Show image w on screen
(gray RGB) viewmat w;'gray RGB'

NB. Convolution in 1dim
NB. use: kernel conv1d vector
NB. produces vector with the same length
conv1d =: +/@:([ * i:@<.@-:@#@[ |."0 _ ])

NB. Convolution in 2dim
NB. use: kernel conv2d matrix
NB. produces matrix with the same shape
conv2d =: adverb def '[: ($ m)"_ +/@,@:(m&*);._3 ]'

NB. use: <standard deviation> gauss <number of samples> 
NB. produces vector with length N = <number of samples> 
gauss =: (%+/) @: (^ @ - @ *: @ -: @ ((i:@<.@-:@]) % [))
gauss2d =: */~ @: ([ gauss ]) f. NB. 2 dimensional gauss N x N

NB. utilities functions
sin =: 1&o.
pix =: (o.1)&*
NB. sinc ( n x ) / n x if |x| > 0 and 1 otherwise
sinc =: (sin @: pix % pix) ` (1:) @. (0:=])
NB. lancosz resampling
NB. http://en.wikipedia.org/wiki/Lanczos_resampling
NB. use: <a> lancosz <number of samples> 
NB. produces vector with length N = <number of samples>
lancosz =: [ (sinc"0@:] * sinc"0@:(] % [)) (-@:|.@:}. , ]) @: ((%>./)@i.@>:@>.@-:@] * [)
lancosz2d =: */~ @: ([ lancosz ]) f. NB. 2 dimensional lancosz N x N
