#message(qmlmodule $$OUT_PWD)

isEmpty(QMLDIR) {
    QMLDIR = $$clean_path($$OUT_PWD/..)
    #message(QMLDIR is $$QMLDIR)
}

QMLTEMPDIR = $$absolute_path($$QMLDIR/$$replace(uri, \., $$QMAKE_DIR_SEP)/..)
unix:system(mkdir -p $$QMLTEMPDIR)
unix:system(ln -s $$_PRO_FILE_PWD_ $$QMLTEMPDIR)

#defineTest(createTestFolder) {
#    for(file, DISTFILES) {
#        folder = $$clean_path($$QMLTEMPDIR/$${file}/..)
#        !exists($$folder) {
#            system(mkdir -p $$folder)
#        }

#        system(cp $${file} $$QMLTEMPDIR/$${file})
#    }

#    return(true)
#}


!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

