$(function() {
          init_draggables_and_droppables();
  });

  function init_draggables_and_droppables() {
  $(function() {
    $(".pieceDrag").draggable({
    });
    $(".pieceDrop").droppable({
      hoverClass: 'highlight',
      drop: Drop
      });

    function Drop(event, ui) {
      var p_id = $(ui.draggable).attr('id');
      var col_id = $(this).data('col-id');
      var row_id = $(this).parent().data('row-id');
      $.ajax({
        type: 'PUT',
        data: { piece_id: p_id, x_coordinate: col_id, y_coordinate: row_id },
        url: $(ui.draggable).data('update-url'),
        dataType: 'json'
        });
    };
  })};