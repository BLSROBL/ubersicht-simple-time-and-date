stylingOptions =
  # background color
  background: 'transparent'
  fullscreen: false
  # display position 'top', 'middle', 'bottom'
  vertical: 'middle'

dateOptions =
  showDate: true
  # 요일 + 일 + 월(월은 아래 update에서 대문자로 변환)
  date: '%A %e %b'

format = (->
  if dateOptions.showDate
    dateOptions.date + '\n' + '%I:%M %p'
  else
    '%I:%M %p'
)()

command: "date +\"#{format}\""

refreshFrequency: 30000

dateOptions: dateOptions

render: (output) -> """
  <div id='simpleClock'>#{output}</div>
"""

update: (output) ->
  if this.dateOptions.showDate
    data = output.split('\n')

    timePart = data[1]
    datePart = data[0]

    # 월(마지막 단어)만 대문자로 변환 -> "Tuesday 9 Sep" -> "Tuesday 9 SEP"
    parts = datePart.trim().split(' ')
    parts[parts.length - 1] = parts[parts.length - 1].toUpperCase()
    datePart = parts.join(' ')

    html = timePart
    html += '<span class="date">'
    html += datePart
    html += '</span>'
  else
    html = output

  $(simpleClock).html(html)

style: (->
  fontSize = '7em'
  width = 'auto'

  if stylingOptions.fullscreen
    fontSize = '10em'
    width = '94%'

  return """
    background: #{stylingOptions.background}
    color: #FFFFFF
    font-family: Helvetica Neue
    left: 50%
    top: 50%
    transform: translate(-50%, -50%)
    width: #{width}
    text-align: center

    #simpleClock
      font-size: #{fontSize}
      font-weight: 100
      margin: 0
      text-align: center
      padding: 10px 20px

    #simpleClock .date
      display: block
      margin-top: .15em
      font-size: .35em
      font-weight: 200
      letter-spacing: 1px
  """
)()
