-- The Has_Subrange function is used to specify if an array is a
-- subrange of another one.

with Types;          use Types;
with Equal_Ranges_P; use Equal_Ranges_P;

package Has_Subrange_P with
   Spark_Mode,
   Ghost
 is

   function Last
     (I : Positive;
      B : T_Arr)
      return Natural is (I - 1 + B'Length) with
      Pre => I - 1 <= Positive'Last - B'Length;

   function Equal_Subrange
     (A     : T_Arr;
      Start : Positive;
      B     : T_Arr)
      return Boolean is (A (Start .. Start - 1 + B'Length) = B) with
      Pre => A'Length >= B'Length and then A'Last < Positive'Last
      and then Start in A'First .. A'Last + 1 - B'Length;

   function Has_Subrange_In_Prefix
     (A    : T_Arr;
      Last : Positive;
      B    : T_Arr)
      return Boolean is
     (for some J in A'First .. Last => Equal_Subrange (A, J, B)) with
      Pre => A'Length >= B'Length and then A'Last < Positive'Last
      and then Last <= A'Last + 1 - B'Length;

   function Has_Not_Subrange_In_Range
     (A     : T_Arr;
      Start : Positive;
      Last  : Positive;
      B     : T_Arr)
      return Boolean is
     (for all J in Start .. Last => not Equal_Subrange (A, J, B)) with
      Pre => A'Length >= B'Length and then A'Last < Positive'Last
      and then Last <= A'Last + 1 - B'Length and then Start in A'First .. Last;

   function Has_Subrange
     (A : T_Arr;
      B : T_Arr)
      return Boolean is
     (for some J in A'First .. A'Last - B'Length + 1 =>
        A (J .. Last (J, B)) = B) with
      Pre => A'Length > 0 and then A'Length >= B'Length
      and then A'Last < Positive'Last;

   function Has_Subrange_2
     (A : T_Arr;
      B : T_Arr)
      return Boolean is
     (Has_Subrange_In_Prefix (A, A'Last + 1 - B'Length, B)) with
      Pre => A'Length > 0 and then A'Length >= B'Length
      and then A'Last < Positive'Last;

   function Has_Subrange_In_Postfix
     (A     : T_Arr;
      Index : Positive;
      B     : T_Arr)
      return Boolean is
     (for some J in Index .. A'Last - B'Length + 1 =>
        Equal_Subrange (A, J, B)) with
      Pre => A'Length >= B'Length and then A'Last < Positive'Last
      and then Index <= A'Last - B'Length + 1 and then Index >= A'First;

end Has_Subrange_P;
