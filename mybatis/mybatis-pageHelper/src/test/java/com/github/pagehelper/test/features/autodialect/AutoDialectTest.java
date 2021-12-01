/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2014-2017 abel533@gmail.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package com.github.pagehelper.test.features.autodialect;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.PageSerializable;
import com.github.pagehelper.mapper.UserMapper;
import com.github.pagehelper.model.User;
import com.github.pagehelper.util.MybatisAutoDialectHelper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.assertEquals;

public class AutoDialectTest {

    @Test
    public void test() {
        SqlSession sqlSession = MybatisAutoDialectHelper.getSqlSession();
        UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
        try {
            //获取第1页，10条内容，默认查询总数count
            PageHelper.startPage(1, 10);
            List<User> list = userMapper.selectAll();
            System.out.println(list);
            PageInfo<User> page = new PageInfo<User>(list);
            assertEquals(1, page.getPageNum());
            assertEquals(10, page.getPageSize());
            assertEquals(1, page.getStartRow());
            assertEquals(10, page.getEndRow());
            assertEquals(183, page.getTotal());
            assertEquals(19, page.getPages());
            assertEquals(true, page.isIsFirstPage());
            assertEquals(false, page.isIsLastPage());
            assertEquals(false, page.isHasPreviousPage());
            assertEquals(true, page.isHasNextPage());

            PageSerializable<User> serializable = PageSerializable.of(list);
            assertEquals(183, serializable.getTotal());


            //获取第2页，10条内容，默认查询总数count
            PageHelper.startPage(2, 10);
            list = userMapper.selectAll();
            page = new PageInfo<User>(list);
            assertEquals(2, page.getPageNum());
            assertEquals(10, page.getPageSize());
            assertEquals(11, page.getStartRow());
            assertEquals(20, page.getEndRow());
            assertEquals(183, page.getTotal());
            assertEquals(19, page.getPages());
            assertEquals(false, page.isIsFirstPage());
            assertEquals(false, page.isIsLastPage());
            assertEquals(true, page.isHasPreviousPage());
            assertEquals(true, page.isHasNextPage());


            //获取第19页，10条内容，默认查询总数count
            PageHelper.startPage(19, 10);
            list = userMapper.selectAll();
            page = new PageInfo<User>(list);
            assertEquals(19, page.getPageNum());
            assertEquals(10, page.getPageSize());
            assertEquals(181, page.getStartRow());
            assertEquals(183, page.getEndRow());
            assertEquals(183, page.getTotal());
            assertEquals(19, page.getPages());
            assertEquals(false, page.isIsFirstPage());
            assertEquals(true, page.isIsLastPage());
            assertEquals(true, page.isHasPreviousPage());
            assertEquals(false, page.isHasNextPage());
        } finally {
            sqlSession.close();
        }
    }

}
