gulp = require('gulp')
exec = require('child_process').exec

gulp.task 'run', ->
    exec('./run.sh', (err, stdout, stderr) ->
        console.log stdout
    )

gulp.task 'watch', ->
    gulp.watch('./test.cpp', ['run'])

gulp.task 'default', ['run', 'watch']
