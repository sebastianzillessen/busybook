$(function () {

  $(document).on('mouseenter', '.table > tbody > tr[data-href]', function () {
    $(this).addClass("active");
  });
  $(document).on('mouseleave', '.table > tbody > tr[data-href]', function () {
    $(this).removeClass("active");
  });
  $(document).on('click', '.table > tbody > tr[data-href] > td:not(:last-child)', function () {
    document.location = $(this).parent("tr[data-href]").attr('data-href');
  });
});
