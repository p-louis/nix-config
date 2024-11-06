{
    pkgs,
    ...
}: {
    programs.notmuch = {
        enable = true;
        new = {
            tags = 
                [
                    "new"
                ];
            ignore = 
                [
                    ".mbsyncstate"
                    ".uidvalidity"
                ];
        };

        search.excludeTags = 
            [
                "junk"
                "deleted"
                "spam"
            ];
        maildir.synchronizeFlags = true;
    };
}
