#!/usr/bin/env python3
from __future__ import print_function

import imaplib
import os
import configparser

dirname = os.path.split(os.path.abspath(__file__))[0]
accounts = configparser.ConfigParser()
accounts.read(os.path.abspath(dirname + '/unread_email.ini'))

hasUnread = False

def count_imap(imap_account):
    if imap_account["useSSL"] == "true":
        client = imaplib.IMAP4_SSL(imap_account["host"], int(imap_account["port"]))
    else:
        client = imaplib.IMAP4(imap_account["host"], int(imap_account["port"]))
    client.login(imap_account["login"], imap_account["password"])
    if "folder" in imap_account:
        client.select(imap_account["folder"])
    else:
        client.select()
    return len(client.search(None, 'UNSEEN')[1][0].split())

for account in accounts:
    if account == "DEFAULT":
        continue

    currentAccount = accounts[account]

    count = count_imap(currentAccount)
    if count:
        hasUnread = True
        break

icon = accounts["DEFAULT"]["icon"]
colorDefault = accounts["DEFAULT"]["colorDefault"]
colorUnread = accounts["DEFAULT"]["colorUnread"]
color = colorUnread if hasUnread else colorDefault

print(f"%{{F#{color}}}{icon}%{{F-}}")
