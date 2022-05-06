package N1.DAO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import N1.entity.SanPham;

@Repository
public class SanPhamDAOImpl implements SanPhamDAO {
	@Autowired
	private SessionFactory sessionFactory;
	private final int pageSize = 15;

	@Override
	public List<SanPham> getDSSanPham() {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<SanPham> query = currentSession.createQuery("from SanPham", SanPham.class);
		return query.getResultList();
	}

	@Override
	public List<SanPham> getDSSanPham(int page, String sort) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<SanPham> query = currentSession.createQuery("from SanPham order by giaSP " + sort, SanPham.class);
		query.setHibernateFirstResult((page - 1) * pageSize);
		query.setMaxResults(pageSize);
		return query.getResultList();
	}

	@Override
	public List<SanPham> getDSSanPham(int page) {
		Session currentSession = sessionFactory.getCurrentSession();
		Query<SanPham> query = currentSession.createQuery("from SanPham", SanPham.class);
		query.setHibernateFirstResult((page - 1) * pageSize);
		query.setMaxResults(pageSize);
		return query.getResultList();
	}

	@Override
	public int getNumberOfPage() {
		return (getDSSanPham().size() + pageSize - 1) / pageSize;
	}

	@Override
	public SanPham addSanPham(SanPham sanPham) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(sanPham);
		return sanPham;
	}

	@Override
	public boolean updateSanPham(int sanPhamId, SanPham sanPham) {
		Session currentSession = sessionFactory.getCurrentSession();
		SanPham tempSanPham = getSanPhamByIdSanPham(sanPhamId);
		if (tempSanPham == null) {
			return false;
		}
		tempSanPham.setGiaMua(sanPham.getGiaMua());
		tempSanPham.setHinhAnh(sanPham.getHinhAnh());
		tempSanPham.setMoTa(sanPham.getMoTa());
		tempSanPham.setTenSp(sanPham.getTenSp());
		tempSanPham.setGiamGia(sanPham.getGiaMua());
		currentSession.saveOrUpdate(tempSanPham);

		return true;
	}

	@Override
	public SanPham getSanPhamByIdSanPham(int sanPhamId) {
		Session currentSession = sessionFactory.getCurrentSession();
		SanPham result = currentSession.get(SanPham.class, sanPhamId);
		return result;
	}

	@Override
	public List<SanPham> getSanPhamByTenSanPham(String tenSP) {
		Session currentSession = sessionFactory.getCurrentSession();
		List<SanPham> sanPhams = new ArrayList<>();
		String query = " SELECT * FROM SanPham where tenSp like N'%" + tenSP + "%'";
		sanPhams = currentSession.createQuery(query, SanPham.class).getResultList();
		return sanPhams;
	}

	@Override
	public SanPham getLatestSanPham() {
		Session currentSession = sessionFactory.getCurrentSession();
		String query = "from SanPham sp Order By sp.maSp DESC";
		Query<SanPham> results = currentSession.createQuery(query, SanPham.class);
		results.setMaxResults(1);
		return results.getSingleResult();
	}

	@Override
	public List<SanPham> getLatestSanPhams(int numOfLines) {
		Session currentSession = sessionFactory.getCurrentSession();
		String query = "from SanPham sp Order By sp.maSp DESC";
		Query<SanPham> results = currentSession.createQuery(query, SanPham.class);
		results.setMaxResults(numOfLines);
		return results.getResultList();
	}

	@Override
	public List<SanPham> getRatedTopSanPhams(int numOfLines) {
		Session currentSession = sessionFactory.getCurrentSession();
		String query = "select * from SanPham sp " 
				+ "where sp.maSp in ( " 
					+ "	select TOP " + numOfLines + " dg.maSP from DanhGia dg " 
					+ "	group by dg.maSP order by AVG(dg.xepHang) desc )";
		Query<SanPham> results = currentSession.createNativeQuery(query, SanPham.class);
		return results.getResultList();
	}

	@Override
	public List<SanPham> getDiscountSanPhams(int numOfLines) {
		Session currentSession = sessionFactory.getCurrentSession();
		String query = "from SanPham sp Order By sp.giamGia DESC";
		Query<SanPham> results = currentSession.createQuery(query, SanPham.class);
		results.setMaxResults(numOfLines);
		return results.getResultList();
	}

	@Override
	public int getNumberOfSanPhams() {
		Session currentSession = sessionFactory.getCurrentSession();
		String query = "select count(*) from SanPham";
		int result = (int) currentSession.createNativeQuery(query).getSingleResult();
		return result;
	}

	@Override
	public List<SanPham> getReviewSanPhams(int numOfLines) {
		Session currentSession = sessionFactory.getCurrentSession();
		String query = "select * from SanPham sp where sp.maSp in ( " 
				+ "	select top " + numOfLines + " dg1.maSp from DanhGia dg1 " 
				+ "	group by dg1.maSp order by count(dg1.maSp) desc )";
		Query<SanPham> results = currentSession.createNativeQuery(query, SanPham.class);
		return results.getResultList();
	}

	@Override
	public void delete(int maSp) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.delete(currentSession.find(SanPham.class, maSp));
	}

	@Override
	public List<SanPham> getFeaturedSanPhams(int numOfLines) {
		Session currentSession = sessionFactory.getCurrentSession();
		String query = "select * from SanPham sp where sp.maSp in ( " 
					+ "	select top " + numOfLines + " sp1.maSp from SanPham sp1, ChiTietHoaDon cthd " 
					+ "	where sp1.maSp = cthd.maSP and sp1.maSp in ( " 
						+ " select top " + numOfLines + " dg.maSP from DanhGia dg " 
						+ " group by dg.maSP order by count(dg.maSP) desc )" 
					+ " group by sp1.maSp order by sum(cthd.soLuong) desc )";
		Query<SanPham> results = currentSession.createNativeQuery(query, SanPham.class);
		return results.getResultList();
	}

	@Override
	public List<SanPham> getSanPhamsByCategoryId(int categoryId, int numOfLines) {
		Session currentSession = sessionFactory.getCurrentSession();
		String query = "select * from SanPham sp where sp.maSp in ( "
					+ " select TOP " + numOfLines + " ctlsp.maSp from ChiTietLoaiSP ctlsp, LoaiSanPham lsp "
					+ " where ctlsp.maLSP = lsp.maLSP "
					+ " and lsp.maLSP = " + categoryId + " )";
		Query<SanPham> results = currentSession.createNativeQuery(query, SanPham.class);
		return results.getResultList();
	}
	
	@Override
	public List<SanPham> getRandomSanPhamsByCategoryId(int categoryId, int numOfLines, int currentSanPhamId) {
		Session currentSession = sessionFactory.getCurrentSession();
		String query = "select * from SanPham sp where sp.maSp in ( "
					+ " select TOP " + numOfLines + " ctlsp.maSp from ChiTietLoaiSP ctlsp, LoaiSanPham lsp "
					+ " where ctlsp.maLSP = lsp.maLSP "
					+ " and lsp.maLSP = " + categoryId 
					+ " and ctlsp.maSp != " + currentSanPhamId
					+ " ORDER BY NEWID() )";
		Query<SanPham> results = currentSession.createNativeQuery(query, SanPham.class);
		return results.getResultList();
	}
}