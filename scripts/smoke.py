#!/usr/bin/env python3
import os,requests,urllib.parse
base=os.environ['BASE_URL'].rstrip('/');nick=os.environ['ADMIN_NICK'];password=os.environ['ADMIN_PASSWORD']
health=requests.get(base+'/healthz.php',timeout=30);data=health.json();assert health.status_code==200 and data['status']=='pass' and data['version'].startswith('2026.05')
node=requests.get(base+'/.well-known/nodeinfo',timeout=30);assert node.status_code==200 and node.json().get('links')
fields={'auth-params':'login','username':nick,'remember':'0','submit':'Sign in','return_path':''}
missing=requests.get(base+'/profile/railway-user-does-not-exist',timeout=30);assert missing.status_code==404
login=requests.Session();page=login.get(base+'/login',timeout=30);assert page.status_code==200 and 'Friendica' in page.text
success=login.post(base+'/login',data={**fields,'password':password},allow_redirects=True,timeout=45);assert success.status_code==200 and 'nav-logout-link' in success.text,success.url
profile=login.get(base+'/profile/'+nick,timeout=30);assert profile.status_code==200 and 'Railway Admin' in profile.text
print('Friendica smoke checks passed')
