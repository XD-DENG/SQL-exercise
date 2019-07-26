select count(device_id),device_id from dc_device_goods_info group by device_id;


select count(*) from dc_device_goods_info where device_id ='024e1b1a523147a4914027af33371c7f';
# 02628664332d46adbf6380d03cbc2493

-- 多列转一列concat_ws 而后再多行转一行group_concat
select count(d.name) count, d.name,d.price,d.picture, group_concat(d.axia SEPARATOR ',') as  '柜号-行-列'
from (


select count(c.name) count,name ,-- c.container_no,c.row,c.col,
       concat_ws('-',c.container_no,c.row,c.col) as axia,c.price,c.picture

from (

select b.name,b.goods_category_id ,b.id as B_ID,a.container_id,a.container_no,a.row,a.col,a.capacity,a.price,b.picture
from (select * from dc_device_goods_info where device_id = '024e1b1a523147a4914027af33371c7f') a
         left join dc_goods b on a.goods_id = b.id  ) c group by c.name,c.container_no, name, c.row, c.col

    ) d  group by d.name;-- where b.name='农夫山泉'






         select b.name,b.goods_category_id ,b.id as B_ID,a.container_id,a.container_no,a.row,a.col,a.capacity,a.price,a.stock_num
from (select * from dc_device_goods_info where device_id = '024e1b1a523147a4914027af33371c7f') a
         left join dc_goods b on a.goods_id = b.id  where b.name='农夫山泉' order by a.container_no,a.row,a.col;


select * from  dc_device_goods_info where device_id='02a039350fae45639401e014ff4dc11e' limit 10;

select count(goods_category_id)
from dc_goods group by goods_category_id;

select distinct name
from dc_goods_category ;