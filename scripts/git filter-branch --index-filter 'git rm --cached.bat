git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | awk '/^blob/ {print substr($0,6)}' | sort --numeric-sort --key=2 | cut --complement --characters=13-40 | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest


git filter-branch --index-filter 'git rm --cached --ignore-unmatch Database1/Database1.dbml ProntoMVC/App_Data/Elmah.sdf .hg/store/data/_pronto_m_v_c/bin/_pronto_m_v_c.pdb.d .hg/store/data/_pronto_m_v_c/obj/_debug/_pronto_m_v_c.pdb.d docstest/28-07-17.txt .vs/ProntoMVC/v15/sqlite3/storage.ide' HEAD  


Total 74552 (delta 45650), reused 74075 (delta 45284)
remote: Resolving deltas: 100% (45650/45650), done.
remote: warning: File .hg/store/data/_pronto_m_v_c/obj/_debug/_pronto_m_v_c.pdb.d is 94.85 MB; this is larger than GitHub's recommended maximum file size of 50.00 MB
remote: error: GH001: Large files detected. You may want to try Git Large File Storage - https://git-lfs.github.com.
remote: error: Trace: 4bdfa9b8c96bee2169bbdc727486a25d
remote: error: See http://git.io/iEPt8g for more information.
remote: error: File ProntoMVC/App_Data/Elmah.sdf is 118.75 MB; this exceeds GitHub's file size limit of 100.00 MB
remote: error: File Database1/Database1.dbmdl is 237.17 MB; this exceeds GitHub's file size limit of 100.00 MB
remote: error: File .hg/store/data/_pronto_m_v_c/bin/_pronto_m_v_c.pdb.d is 101.01 MB; this exceeds GitHub's file size limit of 100.00 MB
remote: error: File ProntoMVC/App_Data/Elmah.sdf is 118.69 MB; this exceeds GitHub's file size limit of 100.00 MB
remote: error: File ProntoMVC/App_Data/Elmah.sdf is 118.56 MB; this exceeds GitHub's file size limit of 100.00 MB
remote: error: File ProntoMVC/App_Data/Elmah.sdf is 118.50 MB; this exceeds GitHub's file size limit of 100.00 MB
remote: error: File ProntoMVC/App_Data/Elmah.sdf is 118.06 MB; this exceeds GitHub's file size limit of 100.00 MB
remote: error: File Database1/Database1.dbmdl is 227.54 MB; this exceeds GitHub's file size limit of 100.00 MB
remote: error: File Database1/Database1.dbmdl is 235.18 MB; this exceeds GitHub's file size limit of 100.00 MB
To https://github.com/mscalella/prontomvc.git
 ! [remote rejected]     develop -> develop (pre-receive hook declined)
error: failed to push some refs to 'https://mscalella:tangalanga1234@github.com/mscalella/prontomvc.git'
Done

Press Enter or Esc to close console...