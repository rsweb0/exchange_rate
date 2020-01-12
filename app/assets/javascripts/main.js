function highlightDataTable(weekpicker) {
  var table = $('.table').DataTable({
    "aoColumnDefs": [
      { "bSortable": false, "aTargets": [ 0, 1, 2, 3, 4, 5 ] }
    ],
    "pageLength": 7
  });

  var inputField = weekpicker.find("input");

  inputField.datetimepicker().on("dp.change", function() {
  var week = weekpicker.getWeek()
  var year = weekpicker.getYear()

  start = moment().year(year).week(week).day('SUNDAY')
  end = moment(start._d).add(7, 'days');
  var maxRate = 0;
  // Set to highest integer value below
  var minRate = 1000000;

  $.fn.dataTable.ext.search.push(
    function(settings, data, dataIndex) {
      var min = start;
      var max = end;
      var startDate = new Date(data[2]);

      if (
          (min == null && max == null ) ||
          (min == null && startDate <= max) ||
          (max == null && startDate >= min) ||
          (startDate <= max && startDate >= min)
        ) {

        if (maxRate < data[3]) {
          maxRate = data[3];
        }

        if (minRate > data[3]) {
          minRate = data[3];
        }

        return true;
      }
      return false;
    }
  );
  $.fn.dataTable.ext.search.push(
    function(settings, data, dataIndex) {
      var row = $(table.row(dataIndex).node())
      if(row.hasClass(`exchange-rate-${maxRate}`)){
        row.addClass('max-rate')
        return true;
      } else if(row.hasClass(`exchange-rate-${minRate}`)) {
        row.addClass('min-rate')
        return true;
      }
      return true;
    }
  );
  table.draw();
  $.fn.dataTable.ext.search.pop();
})
}
