-- =====================================================================
-- LAYİHƏ: ZAVOD - AVADANLIQLARIN SEMERELİLİK VE DAYANMA ANALİZİ
-- ANALİTİK: Şöhlət Əliyev
-- =====================================================================

use test_zavod;

-- =====================================================================
-- 1: Plansız Dayanmaların Biznese Tesiri (Financial & Operational)
-- =====================================================================

select * from avadanliqlar;
select* from dayanma_logu;

select  t1.AvadanliqID, t1.Ad, t1.Tip, t2.Səbəb,
count(t2.LogID) Plansiz_dayanma_sayi,
sum(timestampdiff(minute,t2.BaslamaVaxti,t2.BitmeVaxti)) Toplam_Itki_Deqiqe
from avadanliqlar as t1
 left join dayanma_logu as t2
 on t1.AvadanliqID=t2.AvadanliqID
 Where t2.Tip="Plansız"
 group by 1,2,3,4
 order by Toplam_Itki_Deqiqe desc;
 
 -- =====================================================================
-- 2: Boşda İşləmə və Enerji İtkisi Analizi (Energy Efficiency)
-- =====================================================================
select * from avadanliqlar;
select * from parametr_logu;


select t1.AvadanliqID, t1.Ad, t1.Sahe, t1.Tip,t2.Tezyiq_Bar, t2.Temperatur_C, t2.Axin_m3_h, t2.Enerji_kWh ,

-- Axin 0-dan boyukdurse normal ishleyir.

case
when t2.Axin_m3_h>0 then "Normal Ish rejimi"
else 'Avadanliq Dayanib'
End as Ish_rejimi,

-- Axin 0 oldugu halda Enerji 0-dan boyukdurse enerji itkisi movcuddur.

case 
when t2.Axin_m3_h=0 and t2.Enerji_kWh>0 then t2.Enerji_kWh 
else 0
end as itirilen_enerji
 
from avadanliqlar t1
left join parametr_logu t2 
on t1.AvadanliqID=t2.AvadanliqID
having itirilen_enerji>0;
 
 
 -- =====================================================================
-- 3: Kritik Limitlərin Aşılması (Anomaliyaların Tapılması)
-- =====================================================================
 
 select * from avadanliqlar;
select * from parametr_logu;


select t1.AvadanliqID, t1.Ad, t1.Sahe, t1.Tip, t2.TarixSaat, t2.Tezyiq_Bar, t2.Temperatur_C, t2.Axin_m3_h, t2.Enerji_kWh,

-- Her bir avadanliq uchun kritik hedd teyin edek

case
when t1.Tip='Nasos' and t2.Temperatur_C>36 then 'Yüksək temperatur'
when t1.Tip='Qazan' and t2.Temperatur_C>249 then 'Yüksək temperatur'
when t1.Tip='Kompressor' and t2.Tezyiq_Bar>6.45 then 'Yüksək təzyiq'
else 'Normal ish rejimi'
end  'Alarm'
from avadanliqlar t1
left join parametr_logu t2
on t1.AvadanliqID= t2.AvadanliqID
having Alarm!='Normal ish rejimi';


