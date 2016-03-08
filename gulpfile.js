var gulp = require('gulp');
var postcss = require('gulp-postcss');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');

gulp.task('default', function () {
  return gulp.src('./gulp/assets/stylesheets/app.sass')
    .pipe( sourcemaps.init() )
    .pipe( sass().on('error', sass.logError) )
    .pipe( postcss([ require('autoprefixer'), require('precss') ]) )
    .pipe( sourcemaps.write('.') )
    .pipe( gulp.dest('public/assets/stylesheets/') );
});
