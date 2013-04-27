cheerio = Npm.require 'cheerio'
fs = Npm.require 'fs'
request = Npm.require 'request'
gm = Npm.require 'gm'

base = 'http://erodvd.blog3.mmm.me'

fetch = (url) ->
  result = Meteor.http.call 'GET', base + url,
    headers:
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_3) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.65 Safari/537.31'
  return result.content

load = (url) ->
  return cheerio.load fetch url

removeTag = (html) ->
  return html.replace(/<[^>]+>/g, '')

splitWord = (str) ->
  return str.match(/[^, ][^,]+/g)

Meteor.methods
  scrape: (folder) ->
    this.unblock()
    $ = load('/?q=supd-073')
    elem = $('li > a').eq(1)
    title = elem.text()
    link = elem.attr('href')
    $ = load(link)
    image = $('div.entry_body > p > a > img').attr('src')
    info = $('div#more > p').eq(3).html()
    year = info.match(/\d\d\d\d/)[0]
    actor = info.match(/Cast: ([^<]+)/)[1]
    director = info.match(/Director: ([^ ]+ [^ ]+)/)[1]
    runtime = info.match(/Duration: (\d+)/)[1]
    genre = info.match(/Category: (.+)<br>/)[1]
    genre = removeTag(genre)
    genre = splitWord(genre)
    genreStr = ''
    genreStr += "\n  <genre>#{g}</genre>" for g in genre
    xml = """
    <movie>
      <title>#{title}</title>
      <year>#{year}</year>
      <runtime>#{runtime}</runtime>#{genreStr}
      <director>#{director}</director>
      <actor>
        <name>#{actor}</name>
      </actor>
    </movie>
    """
    path = folder + '/movie.nfo'
    fs.writeFileSync(path, xml)

    jpgPath = folder + '/fanart.jpg'
    jpgUrl = base + image
    request(jpgUrl).pipe fs.createWriteStream jpgPath
    return ''

# Meteor.http.get 'http://javcloud.us/?s=adz-136&submit=Search', (err, result) ->
#   console.log result.content