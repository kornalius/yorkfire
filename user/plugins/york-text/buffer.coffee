{ async } = York
{ Emitter } = require 'event-kit'


class TextPosition


  constructor: (buffer, options) ->
    @emitter = new Emitter
    @_buffer = buffer
    @_row = options?.row ? -1
    @_col = options?.col ? -1
    @_index = options?.index ? -1

    if !@isValidRow() and !@isValidCol()
      @index = 0


  col: (col) ->
    if col? and @_col != col
      @_col = col
      if !@isValidRow()
        @_row = 0
      @_index = -1
      @emitter.emit 'did-change-col', col
      return @
    else
      if @isValidIndex()
        l = @_buffer.lineForIndex(@_index)
        if l?
          return @_index - l.start
        else
          return -1
      else
        return @_col


  row: (row) ->
    if row? and @_row != row
      @_row = row
      if !@isValidCol()
        @_col = 0
      @_index = -1
      @emitter.emit 'did-change-row', row
      return @
    else
      if @isValidIndex()
        l = @_buffer.lineForIndex(@_index)
        if l?
          return l.row
        else
          return -1
      else
        return @_row


  index: (index) ->
    if index? and @_index != index
      @_index = index
      @_col = -1
      @_row = -1
      @emitter.emit 'did-change-index', index
      return @
    else
      if @isValidRow()
        l = @_buffer.lineForRow(@_row)
        if l?
          return l.start() + (if @isValidCol() then @_col else 0)
      else
        return @_index


  onDidChangeCol: (cb) -> @emitter.on 'did-change-col', cb


  onDidChangeRow: (cb) -> @emitter.on 'did-change-row', cb


  onDidChangeIndex: (cb) -> @emitter.on 'did-change-index', cb


  isValidCol: -> @_col != -1


  isValidRow: -> @_row != -1


  isValidIndex: -> @_index != -1


  isEqualTo: (other) ->
    ok = false
    if other.isValidRow()
      ok |= other._row == @_row
    if other.isValidCol()
      ok |= other._col == @_col
    if other.isValidIndex()
      ok |= other._index == @_index
    return ok


class TextRange


  constructor: (buffer, options) ->
    @emitter = new Emitter
    @_buffer = buffer
    @_start = options?.start ? new TextPosition(buffer, index: 0)
    @_end = options?.end ? new TextPosition(buffer, index: 0)


  start: (start) ->
    if start?
      if start instanceof TextPosition and !@_start.isEqualTo(start)
        @_start = start
        @emitter.emit 'did-change-start', index: start
      else if _.isNumber(start)
        start = new TextPosition(@_buffer, index: start)
        if !@_start.isEqualTo(start)
          @_start = start
          @emitter.emit 'did-change-start', index: start
      return @
    else
      return @_start


  end: (end) ->
    if end?
      if end instanceof TextPosition
        @_end = end
        @emitter.emit 'did-change-end', index: end
      else if _.isNumber(end)
        end = new TextPosition(@_buffer, index: end)
        if !@_end.isEqualTo(end)
          @_end = end
          @emitter.emit 'did-change-end', index: end
      return @
    else
      return @_end


  onDidChangeStart: (data) -> @emitter.on 'did-change-start', data


  onDidChangeEnd: (data) -> @emitter.on 'did-change-end', data


  size: -> @_end.index() - @_start.index()


  text: -> @_buffer.text(@_start.index(), @_end.index())


  isEqualTo: (other) ->
    ok = false
    ok |= @_start.isEqualTo(other._start)
    ok |= @_end.isEqualTo(other._end)
    return ok


class Lines


  constructor: (buffer) ->
    @emitter = new Emitter
    @_buffer = buffer
    @_lines = []


  count: -> @_lines.length


  size: -> @lastLine().end


  firstLine: -> _.first(@_lines)


  lastLine: -> _.last(@_lines)


  lineForRow: (row) -> if row in [0...@count()] then @_lines[row] else null


  lineForIndex: (index) -> _.first(@linesForIndexes[index])


  clear: ->
    @_lines.length = 0


  add: (start, end) ->
    @_lines.push(new Line(@_buffer, start, end, @_lines.length))
    return @


  linesForRows: (startRow = 0, endRow = @count() - 1) ->
    lines = []
    if _.isArray(startRow)
      for r in startRow
        lines.push(@_lines[r])
    else if _.isNumber(startRow)
      for r in [startRow..endRow ? startRow]
        lines.push(@_lines[r])
    return lines


  linesForIndexes: (start = 0, end = @size() - 1) ->
    lines = []
    for l in @_lines
      if l.contains(start)
        lines.push(l)
    return lines


  each: (startRow, endRow, fn) ->
    _.each(@linesForRows(startRow, endRow), (v) -> fn(v))
    return @


  contains: (index) ->
    for v in @_lines
      if v.contains(index)
        return v
    return null


  buildLines: (cb) ->
    @clear()
    x = 0
    that = @
    async.eachSeries(@_buffer._text.split(@_buffer.newline), (l, next) ->
      that.add(x, x += l.length + 1)
      process.nextTick -> next()
    , (err) -> cb() if cb?)


  toArray: (startRow, endRow) ->
    a = []
    for l in @linesForRows(startRow, endRow)
      a.push(l.text())
    return a


  toString: (startRow, endRow) ->
    text = ''
    for l in @linesForRows(startRow, endRow)
      text += l.text() + @_buffer.newline
    return text


class Line


  constructor: (buffer, start, end, row) ->
    @emitter = new Emitter
    @_buffer = buffer
    @row = row
    @start = start
    @end = end


  size: -> @end - @start


  text: -> @_buffer.text(@start, @end)


  isBlank: -> not /\S/.test @text()


  contains: (index) ->
    if _.isArray(index)
      for i in index
        if not (i in [@start..@end])
          return false
      return true
    else
      return index in [@start..@end]



class TextBuffer


  constructor: (text = '', encoding = 'utf8') ->
    @emitter = new Emitter
    @newlineRegex = /\r\n|\n|\r/g
    @newline = '\n'
    @_lines = new Lines(@)
    @_text = ''
    @_encoding = 'utf8'
    @text(text)
    @encoding(encoding)

    @onDidChangeText (data) =>
      @buildLines(data?.cb)


  encoding: (encoding) ->
    if encoding? and encoding != @_encoding
      @_encoding = encoding
      @emitter.emit 'did-change-encoding', encoding: encoding
      return @
    else
      return @_encoding


  size: -> @text().length


  count: -> @_lines.length


  isEmpty: -> @size() == 0


  buildLines: (cb) -> @_lines.buildLines(cb)


  text: (start, end, text, cb) ->
    if _.isFunction(text)
      cb = text
      text = null
    if _.isString(start)
      text = start
      start = null
    if _.isString(end)
      text = end
      end = null
    if _.isFunction(end)
      cb = end
      end = null
    if _.isString(text)
      if !start?
        start = 0
      if !end?
        end = text.length - 1
      @_text = @_text.substring(0, start) + text + @_text.substring(end)
      @emitter.emit 'did-change-text', start: start, end: end, cb: cb
      return @
    else
      if !start?
        start = 0
      if !end?
        end = @_text.length - 1
      return @_text.substring(start, end)


  onDidChangeText: (data) -> @emitter.on 'did-change-text', data


  onDidChangeEncoding: (data) -> @emitter.on 'did-change-encoding', data


  insert: (start, end, text) -> @text(start, end, text)


  append: (text) -> @text(@size() - 1, text)


  delete: (start, end) -> @text(start, end, '')


  lastLine: -> @_lines.lastLine()


  lineForRow: (row) -> @_lines.lineForRow(row)


  lineForIndex: (index) -> @_lines.contains(index)


  isRowBlank: (row) -> @lineForRow(row).isBlank()


  previousNonBlankRow: (startRow) ->
    return null if startRow == 0

    startRow = Math.min(startRow, @lastLine().row)
    for row in [(startRow - 1)..0]
      return row unless @isRowBlank(row)
    null


  nextNonBlankRow: (startRow) ->
    lastRow = @lastLine().row
    if startRow < lastRow
      for row in [(startRow + 1)..lastRow]
        return row unless @isRowBlank(row)
    null


  deleteRow: (row) -> @deleteRows(row, row)


  deleteRows: (startRow, endRow) -> @delete(@lineForRow(startRow).start, @lineForRow(endRow).end)


  logLines: (start = 0, end = @lastLine().row - 1) ->
    for row in [start..end]
      line = @lineForRow(row)
      console.log "#{row}: #{line.start} #{line.end} #{line.size()} #{line.text()}"


  toArray: -> @_lines.toArray()


  toString: -> @_text


# _.extend(TextBuffer.prototype, Scanner.extend, History.extend, Transaction.extend, Marker.extend)


module.exports = TextBuffer