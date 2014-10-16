using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Northwind.Model;

namespace Northwind.Repositories
{
    public interface ICategoriesRepository
    {
        Category FindByKey(int key);
        IEnumerable<Category> FindAll();
    }
}