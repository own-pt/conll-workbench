#!/usr/bin/env python3

from serve_depsearch import *

app.run(host='0.0.0.0')
r=requests.get(DEP_SEARCH_WEBAPI+"/metadata") #Ask about the available corpora
metadata=json.loads(r.text)
