\version "2.27.3"
% convert to png using: lilypond --png -dresolution=300 -dpixmap-format=pngalpha /path/to/musicxml/docs/src/data/examples/musicxml/voice-direction-element.ly
\pointAndClickOff

%% additional definitions required by the score:
D = \tweak Stem.direction #DOWN \etc
U = \tweak Stem.direction #UP \etc


\header {
}
\layout {
  \context {
    \Staff
    printKeyCancellation = ##f
    \omit TimeSignature
  }
  \context {
    \Score
    tieWaitForNote = ##t
    autoBeaming = ##f
  }
}
PartPOneVoiceOne = \relative bis' {
  \clef "treble" \time 2/2 \key cis \minor bis2 b2 | % 1
  ais2 a2 | % 2
  gis2 f'2\rest | % 3
  \tweak Y-offset #1.0 R1 | % 4
}

PartPOneVoiceThree = \relative a' {
  \clef "treble" \time 2/2 \key cis \minor
  \override NoteHead.color = #(universal-color 'blue)
  a4 dis,4 gis4 gis4 ~ | % 1
  gis4 fis8 [ eis8 ] fis2 ~ | % 2
  \U \voiceThree fis2 \U e2 | % 3
  \U dis2 \U cis2 }

PartPOneVoiceFive = \relative fis {
  \clef "bass" \time 2/2 \key cis \minor
  \override NoteHead.color = #(universal-color 'vermillion)
  fis8 [ a8 gis8 fis8 ] eis8 [ dis8 eis8
  cis8 ] | % 1
  fis8 [ eis8 fis8 gis8 ] a8 [ gis8 a8 \change Staff="1"
  \D b8 ] \change Staff="2" | % 2
  \change Staff="1" \D cis8 [ \D bis8 \D cis8 \D dis8 ] \D e8 [ \D dis8 \D e8 \D
  fis8 ] \change Staff="2" | % 3
  \change Staff="1" \D gis8 [ \D fis8 \D gis8 \D a8 ] \D gis8 [ \D fis8 \D e8 \D
  gis8 ] }

PartPOneVoiceOneThree = \relative gis, {
  \clef "bass" \time 2/2 \key cis \minor \D gis2 e2\rest | % 1
  \tweak Y-offset #-3.0 R1 | % 2
  \oneVoice cis1 | % 3
  \voiceTwo \D bis2 \D e2 }

PartPOneVoiceNine = \relative f {
  \clef "bass" \time 2/2 \key cis \minor s1*2 | % 2
  s1 | % 3
  f4\rest \U gis,4 \U cis4 \U cis4 }


% The score definition
\score {
  <<
    \new PianoStaff = "P1" \with {
      systemStartDelimiter = #'SystemStartBar
    } <<
      \new PianoStaff <<
        \context Staff = "1" <<
          \mergeDifferentlyDottedOn
          \context Voice = "PartPOneVoiceOne" {
            \voiceOne \PartPOneVoiceOne
          }
          \context Voice = "PartPOneVoiceThree" {
            \voiceTwo \PartPOneVoiceThree
          }
        >>
        \context Staff = "2" <<
          \override Staff.BarLine.allow-span-bar = ##f
          \mergeDifferentlyDottedOn
          \context Voice = "PartPOneVoiceFive" {
            \voiceOne \PartPOneVoiceFive
          }
          \context Voice = "PartPOneVoiceOneThree" {
            \voiceTwo \PartPOneVoiceOneThree
          }
          \context Voice = "PartPOneVoiceNine" {
            \voiceThree \PartPOneVoiceNine
          }
        >>
      >>
    >>
  >>
  \layout {}
  % To create MIDI output, uncomment the following line:
  % \midi { \tempo 4 = 100 }
}

