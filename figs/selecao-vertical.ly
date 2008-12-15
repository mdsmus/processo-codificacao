% Exemplo de seleção vertical
#(set-global-staff-size 20)
{

    <<
        \new Staff{
            \clef treble
            \relative c''{
                r c~ c b \bar"|."
            }}
        \new Staff{
            \clef treble
            \relative c'{
                e4 e f f \bar"|."
            }}
        \new Staff{
            \clef bass
            \relative c' {
                g4 g g g \bar"|."
            }}
        \new Staff{
            \clef bass
            \relative c {
                c4 c g g \bar"|."
            }}

    >>    
}
    \layout { line-width = 7\cm}
