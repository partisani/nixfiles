# Note file syntax highlighter
# Specs will be written later, in pure note format

face global NoteLimit default+ds # Dim + Strikethrough
face global NoteHeader red+b # Bold
face global NoteBold bright-white+b # Bold
face global NoteItalic default+i # Italic
face global NoteLink default+rc # Reverse + Curly underline
face global NoteList bright-white+b # Bold
face global NoteQuote cyan+F # Final
face global NoteBlock cyan+F # Final
face global NoteBlockType red+F # Final
face global NoteBlockInfo yellow+F # Final

hook global BufCreate .*\.nt %{
    addhl -override buffer/note group
    addhl -override buffer/note/limit column 80 NoteLimit
    addhl -override buffer/note/heading regex ^\*+\ [^\n]+ 0:NoteHeader
    addhl -override buffer/note/bold regex \*[^\*\ ].+?\* 0:NoteBold
    addhl -override buffer/note/italic regex /[^/\ ].+?/ 0:NoteItalic
    addhl -override buffer/note/link regex \[[^\ ].+?\] 0:NoteLink
    addhl -override buffer/note/ulist regex ^\+ 0:NoteList
    addhl -override buffer/note/olist regex ^\d+\. 0:NoteList
    addhl -override buffer/note/quote regex ^:[^\n]+ 0:NoteQuote
    addhl -override buffer/note/block \
        regex ^(\\\w+)(?:\ ([^\n]+?))?\ (?:\{\{(.+?)\}\})$ \
        1:NoteBlockType 2:NoteBlockInfo 3:NoteBlock
}
