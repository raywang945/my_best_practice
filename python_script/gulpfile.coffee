gulp = require('gulp')
exec = require('child_process').exec

gulp.task 'python', ->
    exec('python test.py', (err, stdout, stderr) ->
        console.log stderr
        console.log stdout
    )

gulp.task 'watch', ->
    gulp.watch('./test.py', ['python'])

gulp.task 'default', ['python', 'watch']
