using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Data.Entity;
using System.Data.Entity.ModelConfiguration;
using Northwind.Model;

namespace Northwind.Repositories.Entity
{
    internal class NorthwindContext : DbContext
    {
        #region Properties
        public DbSet<Category> Categories { get; set; }

       public DbSet<Supplier> Suppliers { get; set; }

        public DbSet<Product> Products { get; set; }

        #endregion

        #region Methods
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Product>().Property(p => p.Id).HasColumnName("ProductID");
            modelBuilder.Entity<Product>().Property(p => p.Name).HasColumnName("ProductName");

            modelBuilder.Entity<Category>().Property(c => c.Id).HasColumnName("CategoryID");
            modelBuilder.Entity<Category>().Property(c => c.Name).HasColumnName("CategoryName");

            modelBuilder.Entity<Supplier>().Property(s => s.Id).HasColumnName("SupplierID");
            modelBuilder.Entity<Supplier>().Property(s => s.Name).HasColumnName("CompanyName");

            
        }
        #endregion
    }
}
