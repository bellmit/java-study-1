package com.github.pagehelper.test.features.autodialect;

import com.alibaba.druid.pool.DruidDataSource;
import com.github.pagehelper.dialect.AbstractHelperDialect;
import com.github.pagehelper.dialect.auto.DataSourceNegotiationAutoDialect;
import com.github.pagehelper.dialect.auto.DruidAutoDialect;
import com.github.pagehelper.dialect.helper.*;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.commons.dbcp2.BasicDataSource;
import org.apache.ibatis.datasource.unpooled.UnpooledDataSource;
import org.junit.Assert;
import org.junit.Test;

import java.util.Properties;

public class DataSourceNegotiationAutoDialectTest {
    public static final String HIKARI = "jdbc:h2:mem:basetest";
    public static final String DRUID = "jdbc:herddb:mem:basetest";
    public static final String TOMCAT = "jdbc:oracle://localhost/test";
    public static final String C3P0 = "jdbc:mysql://localhost/test";
    public static final String DBCP = "jdbc:postgresql://localhost/test";
    public static final String DEFAULT = "jdbc:hsqldb:mem:basetest";

    private HikariDataSource getHikari() {
        HikariDataSource dataSource = new HikariDataSource();
        dataSource.setJdbcUrl(HIKARI);
        dataSource.setUsername("root");
        dataSource.setPassword("password");
        return dataSource;
    }

    private DruidDataSource getDriud() {
        DruidDataSource dataSource = new DruidDataSource();
        dataSource.setUrl(DRUID);
        dataSource.setUsername("root");
        dataSource.setPassword("password");
        return dataSource;
    }

    private org.apache.tomcat.jdbc.pool.DataSource getTomcatJdbc() {
        org.apache.tomcat.jdbc.pool.DataSource dataSource = new org.apache.tomcat.jdbc.pool.DataSource();
        dataSource.setUrl(TOMCAT);
        dataSource.setUsername("root");
        dataSource.setPassword("password");
        return dataSource;
    }

    private ComboPooledDataSource getC3P0() {
        ComboPooledDataSource dataSource = new ComboPooledDataSource();
        dataSource.setJdbcUrl(C3P0);
        dataSource.setUser("root");
        dataSource.setPassword("password");
        return dataSource;
    }

    private BasicDataSource getDbcp() {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setUrl(DBCP);
        dataSource.setUsername("root");
        dataSource.setPassword("password");
        return dataSource;
    }

    private UnpooledDataSource getDefault() {
        UnpooledDataSource dataSource = new UnpooledDataSource();
        dataSource.setUrl(DEFAULT);
        dataSource.setUsername("sa");
        dataSource.setDriver("org.hsqldb.jdbcDriver");
        return dataSource;
    }

    @Test
    public void testNegotiation() {
        Properties properties = new Properties();
        properties.setProperty("closeConn", "true");
        DataSourceNegotiationAutoDialect autoDialect = new DataSourceNegotiationAutoDialect();
        String dialectKey = autoDialect.extractDialectKey(null, getHikari(), properties);
        Assert.assertEquals(HIKARI, dialectKey);
        AbstractHelperDialect dialect = autoDialect.extractDialect(dialectKey, null, getHikari(), properties);
        Assert.assertTrue(dialect instanceof HsqldbDialect);

        dialectKey = autoDialect.extractDialectKey(null, getDriud(), properties);
        Assert.assertEquals(DRUID, dialectKey);
        dialect = autoDialect.extractDialect(dialectKey, null, getDriud(), properties);
        Assert.assertTrue(dialect instanceof HerdDBDialect);

        dialectKey = autoDialect.extractDialectKey(null, getTomcatJdbc(), properties);
        Assert.assertEquals(TOMCAT, dialectKey);
        dialect = autoDialect.extractDialect(dialectKey, null, getTomcatJdbc(), properties);
        Assert.assertTrue(dialect instanceof OracleDialect);

        dialectKey = autoDialect.extractDialectKey(null, getC3P0(), properties);
        Assert.assertEquals(C3P0, dialectKey);
        dialect = autoDialect.extractDialect(dialectKey, null, getC3P0(), properties);
        Assert.assertTrue(dialect instanceof MySqlDialect);

        dialectKey = autoDialect.extractDialectKey(null, getDbcp(), properties);
        Assert.assertEquals(DBCP, dialectKey);
        dialect = autoDialect.extractDialect(dialectKey, null, getDbcp(), properties);
        Assert.assertTrue(dialect instanceof PostgreSqlDialect);

        dialectKey = autoDialect.extractDialectKey(null, getDefault(), properties);
        Assert.assertEquals(DEFAULT, dialectKey);
        dialect = autoDialect.extractDialect(dialectKey, null, getDefault(), properties);
        Assert.assertTrue(dialect instanceof HsqldbDialect);
    }

    @Test
    public void testDruid() {
        DruidAutoDialect druidAutoDialect = new DruidAutoDialect();
        String jdbcUrl = druidAutoDialect.getJdbcUrl(getDriud());
        Assert.assertEquals(DRUID, jdbcUrl);
        AbstractHelperDialect dialect = druidAutoDialect.extractDialect(jdbcUrl, null, null, null);
        Assert.assertTrue(dialect instanceof HerdDBDialect);
    }

}
