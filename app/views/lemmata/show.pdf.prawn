pdf.font "Helvetica", :size => 12

pdf.text "#{t(:lemma)} #{@lemma.short1} · #{@lemma.short2}", :size => 16, :style => :bold, :spacing => 4


@lemma.categories.each do |category|
  pdf.text category.self_and_ancestors.collect{|e| e.name}.join(" > ")
end

subs = @lemma.subentries.collect{ |e| ["", e.form1, e.form2, ""] }

pdf.table subs,
    :font_size  => 12,
    :horizontal_padding => 10,
    :vertical_padding   => 3,
    :position           => :center,
    :headers            => ["", @lemma.short1, @lemma.short2, ""],
    :align              => {1 => :left},
    :align_headers      => :left,
    :border_style => :underline_header

