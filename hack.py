import json
import urllib2
from HTMLParser import HTMLParser
from urllib2 import Request, urlopen, URLError
from urllib import urlencode
import time
from sets import Set
import os

class MLStripper(HTMLParser):
    def __init__(self):
        self.reset()
        self.fed = []
    def handle_data(self, d):
        self.fed.append(d)
    def get_data(self):
        return ''.join(self.fed)

def strip_tags(html):
    s = MLStripper()
    s.feed(html)
    return s.get_data()

def get_nytimes_comments(offset):
    j = urllib2.urlopen(''.join([\
    'http://api.nytimes.com/svc/community/v2/comments/recent.json',\
    '?offset=', str(offset), \
    '&api-key=1927985037bcd3c7b827cbd04e28c01b:4:56698944']))
    j_obj = json.load(j)
    comment_list = []
    for comment in j_obj['results']['comments']:
        comment_list.append(str(strip_tags(comment['commentBody'].encode('ascii', 'ignore'))))
    return comment_list

def countDuplicatesInList(dupedList):
   uniqueSet = Set(item for item in dupedList)
   return [(item, dupedList.count(item)) for item in uniqueSet]

if __name__ == '__main__':
    parsely_string = ''
    comments_list = []
    for i in range(0,1000,25):
        comments_list.extend(get_nytimes_comments(i))
    parsly_url = 'http://hack.parsely.com/parse'
    values = {'text' : ' '.join(comments_list),\
          'filter_wiki' : 'true'\
            }
    data = urlencode(values)
    req = Request(parsly_url, data)
    try:
        response = urlopen(req)
        parsly_url = json.load(response)
        parsly_submission_url = ''.join(['http://hack.parsely.com', parsly_url['url']])
        while json.load(urlopen(parsly_submission_url))['status'] != 'DONE':
            time.sleep(2)
        else:
            parsely_string = json.load(urlopen(parsly_submission_url))['data']
    except URLError, e:
        if hasattr(e, 'reason'):
            print 'We failed to reach a server.'
            print 'Reason: ', e.reason
        elif hasattr(e, 'code'):
            print 'The server couldn\'t fulfill the request.'
            print 'Error code: ', e.code
    parsely_keys = []
    for element in parsely_string.split('</TOPIC>'):
        if '<TOPIC>' in element:
            parsely_keys.append(str(element [ \
            element.find("<TOPIC>")+\
            len("<TOPIC>") : ].encode('ascii', 'ignore')))
    big_list = []
    for element in countDuplicatesInList(parsely_keys):
        if list(element)[1] > 1:
            big_list.append(list(element))
    big_list = sorted(big_list, key=lambda element: element[1], reverse=True)
    f = open(os.path.join(os.curdir, 'mysql_input.csv'), 'w')
    for element in big_list:
        f.write("\"")
        f.write(element[0])
        f.write("\"")
        f.write(',')
        f.write(str(element[1]))
        f.write('\n')
    f.close()