$(function () {
  $(document)
    .on("ajax:before submit", "form", function () {
      $(this).addClass('loading');
      $(this).find(":input,.btn").attr("diabled", true);
    })
    .on("ajax:complete", "form", function () {
      $(this).removeClass('loading');
      $(this).find(":input,.btn").removeAttr("diabled");
    })
})
