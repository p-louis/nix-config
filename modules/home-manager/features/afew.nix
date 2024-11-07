{ 
pkgs, 
... 
}: {
    programs.afew = {
        enable = true;
        extraConfig = ''
[SpamFilter]
[KillThreadsFilter]
[ListMailsFilter]
[ArchiveSentMailsFilter]
[InboxFilter]

[Filter.1]
message = Tag all bitbucket messages
query = from:notifications-noreply@bitbucket.org
tags = +bitbucket

[Filter.2]
message = Retag some mmhaskell list
query = tag:lists/b5ac64a1b4d7197cdea58a5ea
tags = -lists/b5ac64a1b4d7197cdea58a5ea +lists/mmhaskell

[Filter.3]
message = Retag opsgenie
query = from:opsgenie@eu.opsgenie.net
tags = +lists/opsgenie -unread

[Filter.4]
message = Tag Invites
query = mimetype:text/calendar
tags = +invitation -attachment
        '';
    };

}
