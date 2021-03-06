cheerio = Npm.require 'cheerio'
fs = Npm.require 'fs'
request = Npm.require 'request'
gm = Npm.require 'gm'

Scrapers = new Meteor.Collection 'scrapers'

Meteor.publish 'scrapers', ->
  return Scrapers.find()

@registerScraper = (scraper) ->
  Scrapers.remove { name: scraper.name }
  Scrapers.insert scraper

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
  scrape: (videoId) ->
    this.unblock()
    video = videoFor videoId
    folder = video.path
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
    posterPath = folder + '/poster.jpg'
    jpgUrl = base + image
    jpgStream = request(jpgUrl).pipe fs.createWriteStream jpgPath
    jpgStream.on 'close', ->
      jpg = gm jpgPath
      jpg.size (err, size) ->
        width = size.height * 0.707089552238806
        jpg.crop width, size.height, size.width - width, 0
        jpg.write posterPath, (err) ->
          console.log err if err
    videoScraped videoId
    return ''
