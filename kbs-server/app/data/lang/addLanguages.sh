#!/usr/bin/env bash

echo "Start Import AD_Language Translation..."

cat LangPairs | while read ID_LANG ID_FOLDER
do
#    set -x
    echo "*** Adding language $ID_LANG from folder $IDEMPIERE_HOME/data/lang/$ID_FOLDER *** - $(date +'%Y-%m-%d %H:%M:%S')"
    cd $IDEMPIERE_HOME/utils
    PGPASSWORD=$DB_PASS psql -h $DB_HOST -U $DB_USER -d $DB_NAME -c "UPDATE AD_Language SET IsSystemLanguage='Y', IsLoginLocale='Y' WHERE AD_Language='$ID_LANG'"
    bash RUN_TrlImport.sh $ID_LANG $IDEMPIERE_HOME/data/lang/$ID_FOLDER
done

cd $IDEMPIERE_HOME/utils
echo "*** Synchronize Terminology *** - $(date +'%Y-%m-%d %H:%M:%S')"
bash RUN_SyncTerm.sh

echo "AD_Language Translation Imported!"