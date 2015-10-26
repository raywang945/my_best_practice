gulp       = require('gulp')
coffee     = require('gulp-coffee')
jade       = require('gulp-jade')
server     = require('gulp-server-livereload')
sourcemaps = require('gulp-sourcemaps')
plumber    = require('gulp-plumber')
rimraf     = require('rimraf')

gulp.task 'jade', ->
    gulp.src('./src/**/*.jade')
        .pipe(plumber())
        .pipe(jade(
            pretty: true
        ))
        .pipe(gulp.dest('./dest/'))

gulp.task 'coffee', ->
    gulp.src('./src/coffee/**/*.coffee')
        .pipe(plumber())
        .pipe(sourcemaps.init())
        .pipe(coffee())
        .pipe(sourcemaps.write())
        .pipe(gulp.dest('./dest/js/'))

gulp.task 'clean', (cb) ->
    rimraf('./dest/*', cb)

gulp.task 'watch', ->
    gulp.watch('./src/**/*.jade', ['jade'])
    gulp.watch('./src/coffee/**/*.coffee', ['coffee'])

gulp.task 'webserver', ->
    gulp.src('./dest/')
        .pipe(server(
            livereload: true
            open: true
            port: 8001
        ))

gulp.task 'default', ['clean', 'jade', 'coffee', 'watch', 'webserver']
