var browserSync = require('browser-sync');
var gulp = require('gulp');
var postcss = require('gulp-postcss');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var watch = require('gulp-watch');

gulp.task('sass', function (){
  return gulp.src('./gulp/assets/stylesheets/app.sass')
    .pipe( sourcemaps.init() )
    .pipe( sass().on('error', sass.logError) )
    .pipe( postcss([ require('autoprefixer'), require('precss') ]) )
    .pipe( sourcemaps.write('.') )
    .pipe( gulp.dest('public/assets/stylesheets/') )
    .pipe( browserSync.reload({stream:true}) );
});

gulp.task('browser-sync', function(){
  browserSync({
    proxy: 'localhost:3000',
    files: ['./app/views/**']
  });
});

gulp.task('watch', ['browser-sync'], function(callback){
  watch('./gulp/assets/stylesheets/**/*.sass', function(){
    gulp.start('sass');
  });
});

gulp.task('default', ['sass', 'watch']);
