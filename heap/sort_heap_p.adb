package body Sort_Heap_P with
  SPARK_Mode is


   procedure Sort_Heap(H : in out Heap)
   is
      Interm : Heap := H with ghost;
      N : constant Integer := H.Size;
   begin
      Interm := H;
      pragma assert(Interm.Size <= N);
      For J in  reverse 1 .. N loop
         Interm := H;
         --pragma assert(if J /= N then H.A(J +1)>= H.A(1));

         Pop_Heap(H);


         pragma assert(H.Size+1 <= N);
         pragma Loop_Invariant(H.A(J) >= H.A(1));
         pragma Loop_Invariant(H.Size = J-1);
         pragma Loop_Invariant(Is_Heap_Def(H));
         pragma Loop_Invariant(Multiset_Unchanged(H.A,H'Loop_Entry.A));
         pragma Loop_Invariant(Lower_Bound(H.A(J .. N), H.A(J)));
         pragma Loop_Invariant(Sorted(H.A(J .. N)));
      end loop;
   end Sort_Heap;

end Sort_Heap_P;
