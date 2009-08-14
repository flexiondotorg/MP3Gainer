License

Applies ReplayGain to a MP3 music collection
Copyright (c) 2009 Flexion.Org, http://flexion.org/

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

Introduction

MP3Gainer recursively applies ReplayGain to a MP3 music collection using 
'mp3gain'. ReplayGain can be applied in 'track' or 'album' mode. If 
ReplayGain has previously been applied it can also be undone. It is 
important to understand that MP3Gainer 'album' really is per album, which 
is what you want. Trust me! :-)

The script can be run against a music collection directory structure of
any depth, overcoming issues with similar scripts. You can of course just
process a single directory at a time as well.

The first time you apply ReplayGain it takes a while to process each MP3 
file. However, once a MP3 file has been processed subsequent runs of
'mp3gain' are much, much quicker. Therefore you can reprocess entire 
music collections many times and only the new MP3s will have Replay Gain 
applied.

Usage
  ./MP3Gainer.sh musicdirectory [--track] [--album] [--undo] [--help]

You must supply one of the following modes of operation
  --track : apply Track gain automatically (all files set to equal loudness)
  --album : apply Album gain automatically (files are all from the same
            album: a single gain change is applied to all files, so
            their loudness relative to each other remains unchanged,
            but the average album loudness is normalized)
  --undo  : undo changes made by mp3gain (based on stored tag info)
  --help  : This help.

Requirements

 - bash, cat, echo, ls, mp3gain, which.
   
Known Limitations

 - Uses default settings for 'mp3gain'.
 - Only processes MP3 files.
 
Source Code

You can checkout the current branch from my Bazaar repository. This is a 
read-only repository, get in touch if you want to contribute and require write 
access.

 bzr co http://code.flexion.org/Bazaar/MP3Gainer/

References

 - http://wiki.flexion.org/CDRipping.html

v1.0 2009, 14th August.
 - Initial release
