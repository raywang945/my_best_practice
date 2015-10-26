gulp           = require('gulp')
coffee         = require('gulp-coffee')
jade           = require('gulp-jade')
mainBowerFiles = require('gulp-main-bower-files')
filter         = require('gulp-filter')
server         = require('gulp-server-livereload')
sourcemaps     = require('gulp-sourcemaps')
concat         = require('gulp-concat')
plumber        = require('gulp-plumber')
del            = require('del')

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

gulp.task 'bower', ->
    filterJS = filter('**/*.js', { restore: true })
    gulp.src('./bower.json')
        .pipe(mainBowerFiles())
        .pipe(filterJS)
        .pipe(concat('vendor.js'))
        .pipe(gulp.dest('./dest/js/'))
        .pipe(filterJS.restore)

gulp.task 'clean', ->
    del.sync(['./dest/*'])

gulp.task 'watch', ->
    gulp.watch('./src/**/*.jade', ['jade'])
    gulp.watch('./src/coffee/**/*.coffee', ['coffee'])
    gulp.watch('./bower.json', ['bower'])

gulp.task 'webserver', ->
    gulp.src('./dest/')
        .pipe(server(
            livereload: true
            open: true
            port: 8001
        ))

gulp.task 'default', ['clean', 'jade', 'coffee', 'bower', 'watch', 'webserver']
