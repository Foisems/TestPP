//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TestYourLearning.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class TestScore
    {
        public int Id { get; set; }
        public int IdUser { get; set; }
        public int IdTest { get; set; }
        public int IdScore { get; set; }
    
        public virtual Score Score { get; set; }
        public virtual Test Test { get; set; }
        public virtual User User { get; set; }
    }
}
